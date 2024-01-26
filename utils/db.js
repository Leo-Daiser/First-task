
import { query } from '../lib/db';

export async function getAllSuppliers() {
  const result = await query('SELECT * FROM suppliers');
  return result.rows;
}

export async function getAllMaterials() {
  const result = await query('SELECT * FROM materials');
  return result.rows;
}
