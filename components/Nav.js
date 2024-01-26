import Link from 'next/link';

const Nav = () => (
  <nav>
    <Link href="/">
      <a>Главная</a>
    </Link>{' '}
    |
    <Link href="/suppliers">
      <a>Поставщики</a>
    </Link>{' '}
    |
    <Link href="/materials">
      <a>Материалы</a>
    </Link>
  </nav>
);

export default Nav;
