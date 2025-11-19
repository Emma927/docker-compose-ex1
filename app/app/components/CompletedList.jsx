import React from "react";

export default function CompletedList({ tasks }) {
  return (
    <div style={{ marginTop: "2rem" }}>
      <h2>Zakończone zadania</h2>
      {tasks.length === 0 ? (
        <p>Brak zakończonych zadań</p>
      ) : (
        <ul>
          {tasks.map((task) => (
            <li key={task.id}>{task.title}</li>
          ))}
        </ul>
      )}
    </div>
  );
}
