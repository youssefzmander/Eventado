const mongoose = require('mongoose')



const eventSchema = new mongoose.Schema({

    name: {
        type: String
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
    Ogranisateur: [{ type: mongoose.Schema.ObjectId, ref: "User" }],
    Affiche : {
        type:String
    }

})

module.exports = mongoose.model('Like', eventSchema)