
import React from 'react';
import Layout from '../components/Layout';

const Home = () => {
  return (
    <div className="container">
      <h1 className="title">База данных поставщиков</h1>
      
      <div className="columns">
        <div className="column">
          <a href="/suppliers" className="button is-primary">Поставщики</a>
        </div>
        <div className="column">
          <a href="/materials" className="button is-info">Виды материалов</a>
        </div>
      </div>
    </div>
  );
};

export default Home;
