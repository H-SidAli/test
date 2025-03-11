const express = require('express');

const equipementRouter = express.Router();

const equipementController = require('../controllers/equipementController');

// Create a new equipment
equipementRouter.post('/', equipementController.createEquipement);

// Get all equipment
equipementRouter.get('/', equipementController.getEquipements);

// Get equipment by id
equipementRouter.get('/:id', equipementController.getEquipementById);

// deleteEquipement
equipementRouter.delete('/:id', equipementController.deleteEquipement);

// updateEquipement
equipementRouter.put('/:id', equipementController.updateEquipement);

// phone number as string;
// express validators to validate data;


module.exports = equipementRouter;