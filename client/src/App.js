import {useCallback, useEffect, useState} from 'react'
import axios from 'axios'
import {List} from './List'
import {Form} from './Form'

const BASE_URL = process.env.NODE_ENV === 'production'
  ? "http://31.184.254.152" /* there should be IP from server settings */
  : "http://localhost:5001";

const api = axios.create({ baseURL: BASE_URL });

function App() {
  const [notes, setNotes] = useState([])

  async function createNote(text) {
    const note = await api.post('/api/note', {text})
    setNotes([...notes, {...note.data.note}])
  }

  const fetchNotes = useCallback(async () => {
    const notes = await api.get('/api/note')
    setNotes(notes.data)
  }, [])

  useEffect(() => {
    fetchNotes()
  }, [fetchNotes])

  return (
    <>
      <nav className="navbar">
        <h3>Docker MERN</h3>
      </nav>
      <div className="container with-nav">
        <Form onCreate={createNote} />
        <List list={notes} />
      </div>
    </>
  )
}

export default App;
