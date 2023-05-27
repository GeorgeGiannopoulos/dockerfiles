console.log('------------------------------- Start Initialization -------------------------------');

db = db.getSiblingDB('users');
db.createUser(
    {
        user: 'admin',
        pwd: 'astrongpassword',
        roles: [
            { role: "userAdminAnyDatabase", db: "admin" },
            { role: "readWriteAnyDatabase", db: "admin" },
            { role: "dbAdminAnyDatabase", db: "admin" }
        ]
    },
);

db.createUser(
    {
        user: "defaultusername",
        pwd: "astrongpassword2",
        roles: [
            { role: "userAdmin", db: "data" },
            { role: "dbAdmin", db: "data" },
            { role: "readWrite", db: "data" }
        ]
    },
);

db = db.getSiblingDB('data');
db.createCollection('table1');
db.createCollection('table2');

console.log('------------------------------- End Initialization -------------------------------');
