var express = require('express');
var router = new express.Router();
var knex = require('../db/db.js');
var base32 = require('base32')
 
/* GET users listing. */
router.get('/', (req, res) => {
  knex.table('orders').select('*').
  then((data) => {
    var result = {};
    for (var ic = 0; ic < data.length; ic += 1) {
      result[data[ic].Name] = data[ic].Value;
    }
    res.send(result);
  });
});

router.get('/:id', (req, res) => {
  knex.table('orders').select('*').
where({ id: req.params.id }).
then((data) => res.send(data[0]));
});

router.post('/', (req, res) => {
  var ni = req.body;
  var order = {
    Name : ni.name,
    Koudouni: ni.koudouni,
    Address : ni.address,
    Orofos  : ni.orofos,
    Phone   : ni.phone,
    Comments: ni.comments,
    Items : ni.basketItems,
    Total : ni.basketTotal,
    Extra : ni.hasExtra
  };
  verify(order).
  then(() => {
    // verified
    var pos = parseInt(Math.random()*5) + 2;
    order.id = base32.encode((Math.random() * 10000000 + Math.random() * 10000).toString()).toString().substr(pos,5);
    order.Items = JSON.stringify(order.Items);
    return knex.table('orders')
    .insert(order)
    .then(()=>{
      res.status(200);
      res.send(order);
    });
  }).catch(function(e){
    console.log(e);
    res.status(400);
    res.send('This order shall not pass!');
    return;
  });

//   knex.table('orders').insert(order).
// then((data) => res.send(data));
});


function verifyItem(item){
  if(!item)throw Error({ "msg": "Item is not in my view"});
  // check attributes
  return knex.table('products').select('*').
      where({ id: item.id }).
      then((data) => {
        let product = data[0];
        return  knex.table('attributes').select('*').where({product_id : product.id}).
            then((attrs) => {

              var nattrs = {};
              var money = parseFloat(product.Price);
              for(var ic=0;ic<attrs.length;ic=ic+1){
                nattrs[attrs[ic].id] = attrs[ic];
              }
              for(var id in item.attributes){
                if(!nattrs[id])throw Error("Attribute not in the list");
                var opt = parseInt(item.attributes[id]);
                if(nattrs[id].Options.length <= opt || opt < -1)throw Error("Attribute not in the list2");
                else
                  money = money + parseFloat(nattrs[id].Price);
              }
              return parseFloat(money)*parseInt(item.quantity);
            });
      });
}
function verify(order){
  if(!order.Name || !order.Address || !order.Orofos || !order.Phone || !order.Items || !order.Total)return false;
  let prom = Promise.resolve(0);
  let money = 0;
  for( let ic = 0; ic < order.Items.length; ic = ic + 1 ){
    prom = prom.then( (moremoney) => { 
      const cc = ic;
      money = money + moremoney;
      return verifyItem(order.Items[cc]);
    });
  }
  prom = prom.then(function(lastones){
    money = money + lastones;
    // I have total money and all verified
    // make finale verifications
    if( parseFloat(money).toFixed(2) !== parseFloat(order.Total).toFixed(2) )  throw Error({"msg":"The total is different than the one calculated"});
    //extra charge
    return knex.table('globals').select('*').
    where({ Name: "MinimumOrder" }).
    then((data) => {
      var minimumOrder = data[0].Value;
      if( parseFloat(money) < parseFloat(minimumOrder) && !order.Extra) throw Error({"msg":"The order is under the minimumOrder and you said its not"});
      return money;
    });    
  });
  return prom;
}

module.exports = router;
