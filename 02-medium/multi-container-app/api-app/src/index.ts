import { Hono } from 'hono'
import mongoose from 'mongoose'
import Todo from '../models/todo'

// Connect to MongoDB
mongoose.connect(process.env.MONGO_URI || '', {})
  .then(() => {
    console.log(process.env.MONGO_URI)
    console.log('Connected to MongoDB')
  })
  .catch((error) => {
    console.error('Error connecting to MongoDB:', error)
  }
)

const app = new Hono()

app.get('/', (c) => {
  return c.text('Hello Hono!')
})

app.get('/todos', async (c) => {
  try {
    const todos = await Todo.find()
    return c.json(todos, 200);
  } catch (error) {
    return c.json({ message: 'Error fetching todos', error }, 500)
  }
})

app.post('/todos', async (c) => {
  const req = await c.req.json()

  const todo = new Todo({
    title: req.title,
    description: req.description,
    completed: req.completed,
  })

  console.log('Creating todo:', todo)

  try {
    const newTodo = await todo.save()
    return c.json(newTodo, 201)
  } catch (error) {
    return c.json({ message: 'Error creating todo', error }, 500)
  }
})

app.get('/todos/:id', async (c) => {
  const { id } = c.req.param()

  try {
    const todo = await Todo.findById(id)
    return c.json(todo, 200)
  } catch (error) {
    return c.json({ message: `Todo ${id} not found: ${error}` }, 404)
  }
})

app.put('/todos/:id', async (c) => {
  const { id } = c.req.param()
  const req = await c.req.json()

  try {
    const todo = await Todo.findById(id);

    if (!todo) {
      return c.json({ message: `Todo ${id} not found` }, 404)
    }

    todo.title = req.title || todo.title
    todo.description = req.description || todo.description
    todo.completed = req.completed !== undefined ? req.completed : todo.completed

    const update = await todo.save()
    return c.json(update, 200)
  } catch (error) {
    return c.json({ message: `Error updating Todo ${id}: ${error}` }, 500)
  }
})

app.delete('/todos/:id', async (c) => {
  const { id } = c.req.param()

    try {
    const todo = await Todo.findById(id);

    if (!todo) {
      return c.json({ message: `Todo ${id} not found` }, 404)
    }

    await todo.deleteOne()
    return c.json({ message: `Todo ${id} deleted` }, 200)
    } catch (error) {
    return c.json({ message: `Todo ${id} cant delete: ${error}` }, 404)
    }
})

export default app
