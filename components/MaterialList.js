import React from 'react';

const MaterialList = ({ materials }) => {
  return (
    <div>
      <h1 className="title">Виды материалов</h1>
      <ul>
        {materials.map((material) => (
          <li key={material.id}>{`${material.name} (${material.unit})`}</li>
        ))}
      </ul>
    </div>
  );
};

export default MaterialList;
