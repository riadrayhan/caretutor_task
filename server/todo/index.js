const express = require('express');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();
app.use(bodyParser.json());
app.use(cors());

// Replace with your MongoDB Atlas connection string
const mongoUrl = 'mongodb+srv://riadrayhan111:x52mKF0dac8qKKWM@auth.vz7bo.mongodb.net/authdb';

mongoose.connect(mongoUrl, {
  useNewUrlParser: true,
  useUnifiedTopology: true,
});

// Define the note schema with title, description, text, and createdAt
const noteSchema = new mongoose.Schema({
  title: { type: String, required: true },
  description: { type: String, required: true },
//   text: { type: String, required: true },
  createdAt: { type: Date, default: Date.now },
});

const Note = mongoose.model('Note', noteSchema);

// Get all notes
app.get('/notes', async (req, res) => {
  try {
    const notes = await Note.find();
    res.json(notes);
  } catch (err) {
    res.status(500).send(err);
  }
});

// Add a new note
app.post('/notes', async (req, res) => {
  try {
    const newNote = new Note({
      title: req.body.title,
      description: req.body.description,
    //   text: req.body.text,
    });
    await newNote.save();
    res.status(201).send(newNote);
  } catch (err) {
    res.status(500).send(err);
  }
});

// Delete a note by ID
app.delete('/notes/:id', async (req, res) => {
  try {
    await Note.findByIdAndDelete(req.params.id);
    res.status(204).send();
  } catch (err) {
    res.status(500).send(err);
  }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
