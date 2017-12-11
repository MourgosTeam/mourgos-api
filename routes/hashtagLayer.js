var knex = require('../db/db.js');

function checkHashtag (hash) {
  const hashtag = hash;
  if (hashtag !== '' && hashtag !== null) {

    return knex.table('campaigns').where({ Hashtag: hashtag }).
    select('*').
    then((data) => {
      console.log(data);
      if (data.length === 0) {
        throw new Error({ msg: 'This hashtag doesnt exist.' });
      }
      const [item] = data;
      if (item.CurrentUsages >= item.MaxUsages) {
        throw new Error({
          code: 'No more',
          msg: 'This hashtag is no more available.'
        });
      }

return item;
    });
  }
  throw new Error('Provide hashtag');
}

function updateHashtag (hash) {
  console.log(hash);

return checkHashtag(hash).
  then((item) => {
    console.log(item);
    
    return knex.table('campaigns').
      where({ id: item.id }).
      update({ CurrentUsages: item.CurrentUsages + 1 });
    });
}

module.exports = {
  checkHashtag,
  updateHashtag
};