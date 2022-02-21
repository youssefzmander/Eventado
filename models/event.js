const mongoose = require('mongoose')
const { required } = require('nodemon/lib/config')



const eventSchema = new mongoose.Schema({

    name: {
        type: String,
        required: true
      },
    date: {
        type: Date
    },
    time: {
        type: String
    },
    participants: [{ type: mongoose.Schema.ObjectId, ref: "User" }],
    description: {
        type: String
    },
    Ogranisateur: { type: mongoose.Schema.ObjectId, ref: "User" },
    Affiche : {
        type:String
    }

})

module.exports = mongoose.model('event', eventSchema)