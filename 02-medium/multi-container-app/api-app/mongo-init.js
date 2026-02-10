db.createUser({
  user: 'jian',
  pwd: 'jian123',
  roles: [{ role: 'readWrite', db: 'todos' }],
});
