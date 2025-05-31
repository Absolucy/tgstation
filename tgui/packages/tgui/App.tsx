import { globalStore } from './backend';

export function App() {
  const { getRoutedComponent } = require('./routes');
  const Component = getRoutedComponent(globalStore);

  return <Component />;
}
