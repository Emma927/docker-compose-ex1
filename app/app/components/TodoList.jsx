'use client';

import React from "react";

export default function TodoList({ tasks, onComplete }) {
  return (
    <div>
      <h2>Aktywne zadania</h2>
      {tasks.length === 0 ? (
        <p>Brak zadań</p>
      ) : (
        <ul>
          {tasks.map((task) => (
            <li key={task.id} style={{ marginBottom: "0.5rem" }}>
              {task.title}{" "}
              <button onClick={() => onComplete(task.id)}>✓</button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}
