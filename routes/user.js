const express = require('express');
const router = express.Router();
const userController = require('../controllers/userController');
const auth = require('../middleware/auth');


router.get('/:id',userController.getById);

router.post('/', userController.createUser);

router.post('/login',userController.login);

router.put('/:id',auth,userController.updateUser);

router.get("/confirmation/:token", userController.confirmation);

router.post("/resendConfirmation", userController.resendConfirmation);

router.post("/forgotPassword", userController.forgotPassword);





module.exports = router;