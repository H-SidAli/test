const express = require('express');

const interventionRouter = express.Router();

const interventionController = require('../controllers/interventionController');    

// Get all interventions
interventionRouter.get('/', interventionController.getInterventions);