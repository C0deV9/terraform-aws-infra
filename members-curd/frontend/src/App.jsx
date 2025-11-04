import React, { useEffect, useState } from 'react';
import axios from 'axios';

const API_URL = 'http://localhost:3000/api/members';

export default function App() {
  const [members, setMembers] = useState([]);
  const [form, setForm] = useState({ name: '', email: '', phone: '' });

  const load = async () => {
    const res = await axios.get(API_URL);
    setMembers(res.data);
  };

  useEffect(() => { load(); }, []);

  const handleSubmit = async (e) => {
    e.preventDefault();
    await axios.post(API_URL, form);
    setForm({ name: '', email: '', phone: '' });
    load();
  };

  const handleDelete = async (id) => {
    await axios.delete(`${API_URL}/${id}`);
    load();
  };

  return (
    <div style={{ maxWidth: 600, margin: 'auto', padding: 20 }}>
      <h1>Members CRUD</h1>
      <form onSubmit={handleSubmit}>
        <input placeholder="Name" value={form.name} onChange={e => setForm({ ...form, name: e.target.value })} required />
        <input placeholder="Email" value={form.email} onChange={e => setForm({ ...form, email: e.target.value })} required />
        <input placeholder="Phone" value={form.phone} onChange={e => setForm({ ...form, phone: e.target.value })} />
        <button type="submit">Add</button>
      </form>
      <ul>
        {members.map(m => (
          <li key={m.memberId}>
            {m.name} ({m.email}) <button onClick={() => handleDelete(m.memberId)}>❌</button>
          </li>
        ))}
      </ul>
    </div>
  );
}
