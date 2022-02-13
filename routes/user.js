const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require('../middleware/auth');


router.post('/', userController.createUser);

router.post('/login',userController.login);

router.put('/:id',auth,userController.updateUser);





module.exports = router;