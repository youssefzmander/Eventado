var mongoose = require('mongoose');
const express = require('express');
const event = require('../models/event');
const User = require('../models/user');


exports.getAllEvents = async (req, res) => {
    try {
        const event = await event.find()
        res.json(event)
    } catch (err) {
        res.status(500).json({ message: err.message })
    }
}
/*
exports.createEvent =  (req, res) => {
    const event = new event({
        name: req.body.name,
        date: req.body.date,
        time: req.body.time,
        participants: req.body.participants,
        Ogranisateur: req.body.Ogranisateur,
        Affiche: req.body.Affiche,

    });
    event.save()
        .then(() => res.status(201).json(event))
        .catch(error => res.status(400).json({ error }));


};
*/




exports.createEvent = async (req, res) => {

    const { name, date, time, participants, ogranisateur, Affiche } = req.body;

    const verifEvent = await event.findOne({ name });
    if (verifEvent) {
        res.status(403).send({ message: "event already exists !" });
    } else {
        const newEvent = new event();
        newEvent.name = name;
        newEvent.date = date;
        newEvent.Affiche = Affiche;
        newEvent.ogranisateur=req.params.id
        newEvent.save();
        res.status(201).json({ newEvent });
    }
}