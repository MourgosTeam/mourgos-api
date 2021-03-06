var knex = require('../db/db.js');
var auth = require('../helpers/auth');


function formLog(...data) {
    const [
    uid,
    t,
    v,
    eid
    ] = data;

    return {
      EntityID: eid,
      Type: t,
      Value: v,
      user_id: uid
    };
}
function logIt(...data) {
  const [
    req,
    type,
    value,
    entityid
  ] = data;

  const uid = auth.getUserID(req);

  if (uid === false) {

    return false;
  }

  const log = formLog(uid, type, value, entityid);

  return knex.table('userlogs').insert(log).
  catch((err) => console.log(err));
}

function logIfNotExists(...data) {
  const [
    req,
    type,
    value,
    entityid
  ] = data;

  const uid = auth.getUserID(req);
  if (uid === false) {
    return false;
  }

const whereClause = {
            EntityID: entityid,
            Type: type,
            Value: value,
            user_id: uid
        };

return knex.table('userlogs').where(whereClause).
        select('*').
        then((cols) => {
            if (cols.length === 0) {

                return logIt(req, type, value, entityid);
            }

            return false;
        });
}

module.exports = {
    log: logIt,
    logIfNotExists
};