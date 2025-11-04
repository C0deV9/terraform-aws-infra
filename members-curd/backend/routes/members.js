const express = require('express');
const router = express.Router();
const Member = require('../models/member');

// Create member
router.post('/', async (req, res) => {
  try {
    const member = new Member(req.body);
    await member.save();
    res.status(201).json(member);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Get all members
router.get('/', async (req, res) => {
  const members = await Member.find().sort({ memberId: 1 });
  res.json(members);
});

// Get single member by memberId
router.get('/:memberId', async (req, res) => {
  const member = await Member.findOne({ memberId: req.params.memberId });
  if (!member) return res.status(404).json({ error: 'Not found' });
  res.json(member);
});

// Update member by memberId
router.put('/:memberId', async (req, res) => {
  try {
    const updated = await Member.findOneAndUpdate({ memberId: req.params.memberId }, req.body, { new: true });
    if (!updated) return res.status(404).json({ error: 'Not found' });
    res.json(updated);
  } catch (err) {
    res.status(400).json({ error: err.message });
  }
});

// Delete member
router.delete('/:memberId', async (req, res) => {
  const deleted = await Member.findOneAndDelete({ memberId: req.params.memberId });
  if (!deleted) return res.status(404).json({ error: 'Not found' });
  res.json({ message: 'Deleted successfully' });
});

module.exports = router;
