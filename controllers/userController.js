const User = require('../models/user');
var mongoose = require('mongoose');
const bcrypt = require('bcrypt');
const express = require('express');
const jwt = require('jsonwebtoken');
const user = require('../models/user');
const nodemailer = require("nodemailer");




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
    newUser.role = role;

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
    const token = makeTokenForLogin(user._id, user.role)

    /*if (!user.isVerified) {
        res.status(200).send({ message: "email not verified" });
    } else {*/
    res.status(200).send({ token, UserId: user._id });
    /* }*/

  } else {
    res.status(403).send({ message: "email or password incorrect" });
  };
}