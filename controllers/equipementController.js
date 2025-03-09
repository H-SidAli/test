const equipementService = require("../services/equipementServices");

// createEquipement function
async function createEquipement(req, res) {
    try {
        const {
            codeInventaire,
            designation,
            affectation,
            typeId,
            etat,
            misEnService,
            dateAcquisition,
        } = req.body;

        // validate required fields
        if (!codeInventaire || !typeId || !designation || !affectation) {
            return res.status(400).json({ error: "All fields are required" });
        }

        const newEquipement = await equipementService.createEquipement(
            req.body
        );

        res.status(201).json(newEquipement);
    } catch (error) {
        console.error("Error creating equipment:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

// getEquipements function
async function getEquipements(req, res) {
    try {
        const equipements = await equipementService.getEquipements();
        res.status(200).json(equipements);
    } catch (error) {
        console.error("Error getting equipments:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

// getEquipementById function
async function getEquipementById(req, res) {
    try {
        const equipementId = parseInt(req.params.id);
        const equipement = await equipementService.getEquipementById(
            equipementId
        );
        if (!equipement) {
            return res.status(404).json({ error: "Equipment not found" });
        }
        res.status(200).json(equipement);
    } catch (error) {
        console.error("Error getting equipment by id:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }
}

module.exports = { createEquipement, getEquipements , getEquipementById };
