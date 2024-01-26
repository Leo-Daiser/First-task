
import { fetchMaterials } from '../lib/db';
import Layout from '../components/Layout';

export async function getStaticProps() {
  const materials = await fetchMaterials();

  return {
    props: {
      materials,
    },
  };
}

const MaterialsPage = ({ materials }) => {
  return (
    <div>
      <h1>Materials</h1>
      <table>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Unit of Measurement</th>
          </tr>
        </thead>
        <tbody>
          {materials.map((material) => (
            <tr key={material.id}>
              <td>{material.id}</td>
              <td>{material.name}</td>
              <td>{material.unit_of_measurement}</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default MaterialsPage;
