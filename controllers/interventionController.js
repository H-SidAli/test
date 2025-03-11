const inverventionService = require('../services/interventionServices');

// get all interventions

async function getInterventions(req, res) {
    try{
        const interventions = await interventionService.getInterventions();
        res.status(200).json(interventions);
    }
    catch(error){
        console.error("Error fetching interventions list:", error);
        res.status(500).json({ error: "Internal Server Error" });
    }