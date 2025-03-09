const express = require('express');

const app = express();

const equipementRoutes = require('./routes/equipementRoutes');

app.use(express.json());


app.use('/equipements', equipementRoutes);


app.get('/', (req, res) => {
    res.send('API is running...');
});


app.listen(3000, () => {
    console.log(`Server is running on 3000`);
});


module.exports = app;