var knex = require('../db/db.js');

function checkHashtag (hash) {
  const hashtag = hash;
  if (hashtag !== '' && hashtag !== null && typeof hashtag !== 'undefined') {
    return knex.table('campaigns').where({ Hashtag: hashtag }).
    select('*').
    then((data) => {
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
  const error = new Error('No code. Received hashtag: ' + hash);
  error.errorObject = {
    code: 8001,
    msg: 'No code'
  };

  return Promise.reject(error);
}

function updateHashtag (hash) {
  console.log(hash);

return (
  checkHashtag(hash).
  then((item) => {
    console.log(item);

    return knex.table('campaigns').
      where({ id: item.id }).
      update({ CurrentUsages: item.CurrentUsages + 1 });
  }).
  catch((err) => {
    if (err.errorObject.code === 8001) {
      return true;
    }
    throw err;
  }));
}

module.exports = {
  checkHashtag,
  updateHashtag
};