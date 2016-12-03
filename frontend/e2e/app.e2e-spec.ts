import { TestTestPage } from './app.po';

describe('test-test App', function() {
  let page: TestTestPage;

  beforeEach(() => {
    page = new TestTestPage();
  });

  it('should display message saying app works', () => {
    page.navigateTo();
    expect(page.getParagraphText()).toEqual('app works!');
  });
});
