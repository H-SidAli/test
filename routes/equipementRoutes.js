const express = require('express');

const router = express.Router();

const equipementController = require('../controllers/equipementController');

// Create a new equipment
router.post('/', equipementController.createEquipement);

// Get all equipment
router.get('/', equipementController.getEquipements);

// Get equipment by id
router.get('/:id', equipementController.getEquipementById);

module.exports = router;