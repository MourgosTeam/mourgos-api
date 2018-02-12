var knex = require('../db/db.js');

function getSiteStatus() {
  return knex.table('globals').select('*').
  where({ Name: 'MourgosIsLive' }).
  orWhere({ Name: 'MourgosHasProblem' }).
  orWhere({ Name: 'MourgosWorkingHours' }).
  then((data) => {
    const globals = data.
    reduce((initial, item) => {
      initial[item.Name] = item.Value;

      return initial;
    }, {});
    const hours = globals.MourgosWorkingHours.split('-');
    const today = new Date();
    const now = (today.getHours() < 10
      ? '0'
      : '') + today.getHours() + ':' +
    (today.getMinutes() < 10
      ? '0'
      : '') + today.getMinutes();

    const isWorking = hours[0] <= now && now <= hours[1]
                    ? 1
                    : 0;

    return Math.max(
        isWorking,
        globals.MourgosIsLive,
        2 * globals.MourgosHasProblem
    );
  });
}

module.exports = { getSiteStatus };