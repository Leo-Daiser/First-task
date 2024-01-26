import Link from 'next/link';

const Layout = ({ children }) => {
  return (
    <div>
      <nav>
        <Link href="/">
          <a>Главная</a>
        </Link>{' '}
        |{' '}
        <Link href="/suppliers">
          <a>Поставщики</a>
        </Link>{' '}
        |{' '}
        <Link href="/materials">
          <a>Материалы</a>
        </Link>
      </nav>
      {children}
    </div>
  );
};

export default Layout;
