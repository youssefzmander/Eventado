const User = require('../models/user');
var mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const express = require('express');
const jwt = require('jsonwebtoken');
const Role = require('../middleware/roles');
const nodemailer = require("nodemailer");



exports.getById = async (req, res) => {
  const user = await User.findOne({ _id: req.body._id });

  if (user) {
    res.status(200).send({ user });
  } else {
    res.status(403).send({ message: "fail" });
  }
};



exports.createUser = async (req, res) => {

  const { name, email, password, role } = req.body;

  const verifUser = await User.findOne({ email });
  if (verifUser) {
    res.status(403).send({ message: "User already exists !" });
  } else {

    const newUser = new User();
    mdpEncrypted = await bcrypt.hash(password, 10);
    newUser.name = name;
    newUser.email = email;
    newUser.password = mdpEncrypted;
    newUser.isVerified = false;
    //newUser.role = role;

    const token = jwt.sign({ _id: newUser._id }, process.env.token_secret, {
      expiresIn: "60000", // in Milliseconds (3600000 = 1 hour)
    });

    sendConfirmationEmail(email, token);

    newUser.save();
    res.status(201).json({ newUser });

  }
}

exports.updateUser = async (req, res) => {
  const user = new User({
    _id: req.params.id,
    ...req.body
  });
  User.updateOne({ _id: req.params.id }, user).then(
    () => {
      res.status(201).json({
        message: 'user updated successfully!',
        user
      });
    }
  ).catch(
    (error) => {
      res.status(400).json({
        error: error
      });
    }
  );
}


function makeTokenForLogin(_id, role) {
  return jwt.sign({ _id: _id, role: role }, process.env.token_secret, {
    expiresIn: "99999999999", // in Milliseconds (3600000 = 1 hour)
  });
}

exports.login = async (req, res, next) => {
  const { email, password } = req.body;

  const user = await User.findOne({ email });

  if (user && (await bcrypt.compare(password, user.password))) {

    // token creation
    const token = makeTokenForLogin(user._id)

    if (!user.isVerified) {
      res.status(200).send({ message: "email not verified" });
    } else {
      res.status(200).send({ token, UserId: user._id });
    }

  } else {
    res.status(403).send({ message: "email or password incorrect" });
  };
}


//fuctions
async function sendConfirmationEmail(email, token) {
  // create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: 'eventado344@gmail.com',
      pass: 'eventado123!'
    }
  });

  transporter.verify(function (error, success) {
    if (error) {
      console.log(error);
    } else {
      console.log("Server is ready to take our messages");
    }
  });

  const link = token;

  const mailOptions = {
    from: 'eventado344@gmail.com',
    to: email,
    subject: 'Confirm your email',
    html: "<h3>Please confirm your email using this verification : </h3><h1><p>" + link[0] + link[1] + link[2] + link[3] + "</p></h1>" + link
  };

  transporter.sendMail(mailOptions, function (error, info) {
    if (error) {
      console.log(error);
    } else {
      console.log('Email sent: ' + info.response);
    }
  });
}


exports.confirmation = async (req, res) => {

  var tokenValue;
  try {
    tokenValue = jwt.verify(req.params.token, process.env.token_secret);
  } catch (e) {
    return res.status(400).send({ message: 'The confirmation link expired, please reverify.' });
  }

  User.findById(tokenValue._id, function (err, user) {
    if (!user) {
      return res.status(401).send({ message: 'User not found, please sign up.' });
    }
    else if (user.isVerified) {
      return res.status(200).send({ message: 'This mail has already been verified, please log in' });
    }
    else {
      user.isVerified = true;
      user.save(function (err) {
        if (err) {
          return res.status(500).send({ message: err.message });
        }
        else {
          return res.status(200).send({ message: 'Your account has been verified' });
        }
      });
    }
  });
}

exports.resendConfirmation = async (req, res) => {
  const user = await User.findOne({ "email": req.body.email });

  if (user) {
    // token creation
    const token = jwt.sign({ _id: user._id, email: user.email }, process.env.token_secret, {
      expiresIn: "60000", // in Milliseconds (3600000 = 1 hour)
    });

    sendConfirmationEmail(req.body.email, token);

    res.status(200).send({ "message": "Confirmation email has been sent to " + user.email })
  } else {
    res.status(404).send({ "message": "User not found" })
  }
};

exports.forgotPassword = async (req, res) => {
  const resetCode = req.body.resetCode
  const user = await User.findOne({ "email": req.body.email });

  if (user) {
      // token creation
      const token = jwt.sign({ _id: user._id, email: user.email }, process.env.token_secret, {
          expiresIn: "3600000", // in Milliseconds (3600000 = 1 hour)
      });

      sendPasswordResetEmail(req.body.email, token, resetCode);

      res.status(200).send({ "message": "Reset email has been sent to " + user.email })
  } else {
      res.status(404).send({ "message": "User not found" })
  }
};



async function sendPasswordResetEmail(email, token, resetCode) {
  // create reusable transporter object using the default SMTP transport
  let transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
          user: 'eventado344@gmail.com',
          pass: 'eventado123!'
      }
  });

  transporter.verify(function (error, success) {
      if (error) {
          console.log(error);
      } else {
          console.log("Server is ready to take our messages");
      }
  });

  const mailOptions = {
      from: 'eventado344@gmail.com',
      to: email,
      subject: 'Reset your password',
      html: "<h2>Use this as your reset code : " + resetCode + "</h2>"
  };

  transporter.sendMail(mailOptions, function (error, info) {
      if (error) {
          console.log(error);
      } else {
          console.log('Email sent: ' + info.response);
      }
  });
}