
import { fetchSuppliersWithMaterials } from '../lib/db';
import styles from '../styles/Suppliers.module.css';
import Layout from '../components/Layout';

export async function getStaticProps() {
  const suppliers = await fetchSuppliersWithMaterials();

  return {
    props: {
      suppliers,
    },
  };
}

const SuppliersPage = ({ suppliers }) => {
  return (
    <div>
      <h1>Suppliers</h1>
      <table className={styles.suppliersTable}>
        <thead>
          <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Type</th>
            <th>Phone</th>
            <th>Address</th>
            <th>Materials</th>
          </tr>
        </thead>
        <tbody>
          {suppliers.map((supplier, index) => (
            <tr key={supplier.id}>
              <td>{index + 1}</td>
              <td>{supplier.name}</td>
              <td>{supplier.type}</td>
              <td>{supplier.phone}</td>
              <td>{supplier.address}</td>
              <td>
                <ul>
                  {supplier.materials.map((material) => (
                    <li key={material.id}>{material.name}</li>
                  ))}
                </ul>
              </td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
};

export default SuppliersPage;
