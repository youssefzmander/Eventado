const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const crypto = require('crypto')


const UserSchema = new mongoose.Schema({

  f_name: {
    type: String,
  },
  email: {
    type: String
  },
  password: {
    type: String,
  },
  avatar: {
    type: String
  },
  isVerified: {
    type: Boolean
  },
  resetPasswordToken: {
    type: String
  },
  resetPasswordExpires: {
    type: Date,
    required: false
  },
  friends: [{ type: mongoose.Schema.ObjectId, ref: "User" }]
},
  { timestamps: true })





//mongoose.set('useFindAndModify', false);


module.exports = mongoose.model('User', UserSchema)
