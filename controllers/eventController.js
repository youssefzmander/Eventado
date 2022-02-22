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

exports.createEvent = async (req, res) => {

    const { name, date, time, participants, ogranisateur, Affiche } = req.body;

    const verifEvent = await event.findOne({ name });
    if (verifEvent) {
        res.status(403).send({ message: "event already exists !" });
    } else {
        const newEvent = new event();
        newEvent.name = name;
        newEvent.date = date;
        newEvent.Affiche = "http://localhost:3001/" + req.file.path
        newEvent.save();
        res.status(201).json({ newEvent });
    }
}



exports.updateEvent = async (req, res) => {
    const event = new event({
      _id: req.params.id,
      ...req.body
    });
    event.updateOne({ _id: req.params.id }, event).then(
      () => {
        res.status(201).json({
          message: 'event updated successfully!',
          event
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


  exports.deleteEvent = async (req, res) => {
    event.deleteOne({_id: req.params.id}).then(
      () => {
        res.status(200).json({
          message: 'Deleted!'
        });
      }
    ).catch(
      (error) => {res.status(400).json({error: error});
      }
    );
  } 
  


