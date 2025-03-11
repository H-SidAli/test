const express = require('express');

const equipementTypeRouter = express.Router();

const equipementTypeController = require('../controllers/equipementTypeController');

// getAllEquipementTypes
equipementTypeRouter.get('/', equipementTypeController.getAllEquipementTypes);

equipementTypeRouter.post('/', equipementTypeController.createEquipementType);

equipementTypeRouter.delete('/:id', equipementTypeController.deleteEquipementType);

module.exports = equipementTypeRouter;