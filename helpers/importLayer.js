var knex = require('../db/db.js');

function getIoUQuery (table, data) {
    const insert = knex(table).insert(data);

    const temp = data.id;
    Reflect.deleteProperty(data, 'id');
    const update = knex(table).update(data);
    data.id = temp;

    const query = insert.toString() + ' on duplicate key update ' +
         update.toString().replace(/^update ([`"])[^\1]+\1 set/i, '');

    return knex.raw(query);
}

function insertOrUpdate(table, data) {
    const queries = [];
    for (var ic = 0; ic < data.length; ic += 1) {
        queries.push(getIoUQuery(table, data[ic]));
    }

    return Promise.all(queries).then(() => true).
    catch((err) => {
        console.log('TABLE: ' + table);
        console.log(err);
    });
}

module.exports = {
    getIoUQuery,
    insertOrUpdate
};