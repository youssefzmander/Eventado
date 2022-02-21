const express = require('express');
const router = express.Router();
const eventController = require('../controllers/eventController');

router.get('/', eventController.getAllEvents);

router.post('/:id',eventController.createEvent);




module.exports = router;