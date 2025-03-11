const express = require('express');

const app = express();

const equipementRouter = require('./routes/equipementRoutes');
const equipementTypeRouter = require('./routes/equipementTypeRoutes.js');

app.use(express.json());


app.use('/equipements', equipementRouter);
app.use('/equipementTypes', equipementTypeRouter);
app.use('/interventions', interventionRouter);


app.get('/', (req, res) => {
    res.send('API is running...');
});


app.listen(3000, () => {
    console.log(`Server is running on 3000`);
});


module.exports = app;