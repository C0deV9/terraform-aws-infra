const mongoose = require('mongoose');
const Counter = require('./counter');

const MemberSchema = new mongoose.Schema({
  memberId: { type: Number, unique: true },
  name: { type: String, required: true },
  email: { type: String, required: true, unique: true },
  phone: { type: String },
  createdAt: { type: Date, default: Date.now }
});

MemberSchema.pre('save', async function (next) {
  if (this.isNew) {
    const counter = await Counter.findByIdAndUpdate(
      'memberId',
      { $inc: { seq: 1 } },
      { new: true, upsert: true }
    );
    this.memberId = counter.seq;
  }
  next();
});

module.exports = mongoose.model('Member', MemberSchema);
