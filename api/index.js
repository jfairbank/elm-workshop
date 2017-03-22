/* eslint-disable no-console */
const express = require('express');
const axios = require('axios');
const cors = require('cors');
const userCache = require('./users.json');

const app = express();

app.use(cors());

app.get('/users/:login', (req, res) => {
  const { login } = req.params;

  if (login.toLowerCase() === 'nouser') {
    setTimeout(() => {
      res.status(404).send({
        message: 'Not Found',
        documentation_url: 'https://developer.github.com/v3',
      });
    }, 500);
  } else if (userCache[login]) {
    setTimeout(() => {
      res.send(userCache[login]);
    }, 750);
  } else {
    const url = `https://api.github.com/users/${login}`;

    axios.get(url).then(
      ({ data }) => {
        userCache[login] = data;

        setTimeout(() => {
          res.send(data);
        }, 500);
      },

      (e) => {
        const { response } = e;

        res
          .status(response.status)
          .send(response.data);
      }
    );
  }
});

app.listen(3001, () => {
  console.log('Server listening at http://localhost:3001');
});
