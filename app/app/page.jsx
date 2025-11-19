'use client';
import { useState } from "react";
import TodoForm from "./components/TodoForm";
import TodoList from "./components/TodoList";
import CompletedList from "./components/CompletedList";
import { Container, Typography, Box } from "@mui/material";

export default function Home() {
  const [tasks, setTasks] = useState([]);
  const [completedTasks, setCompletedTasks] = useState([]);

  const handleComplete = (id) => {
    const task = tasks.find((t) => t.id === id);
    if (!task) return;
    setCompletedTasks([...completedTasks, task]);
    setTasks(tasks.filter((t) => t.id !== id));
  };

  return (
    <Container maxWidth="sm" sx={{ mt: 4 }}>
      <Typography variant="h3" align="center" gutterBottom>
        Moja aplikacja ToDo
      </Typography>

      <Box sx={{ my: 4 }}>
        <TodoForm onAddTask={(newTask) => setTasks([...tasks, newTask])} />
      </Box>

      <Box sx={{ my: 4 }}>
        <TodoList tasks={tasks} onComplete={handleComplete} />
      </Box>

      <Box sx={{ my: 4 }}>
        <CompletedList tasks={completedTasks} />
      </Box>
    </Container>
  );
}
