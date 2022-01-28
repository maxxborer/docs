## REGEX
Найти любой набор тегов в vscode (react || html) по принципу `Parent` -> `Child`:
```html
<Parent[\s\S]+<Child[\s\S]+<\/Parent>
```
Пример:
```html
<NavigationLink[\s\S]+<Button[\s\S]+<\/NavigationLink>
```
![image](https://user-images.githubusercontent.com/44510263/151523092-f82618c8-61b3-45ef-a82b-a43126e7f998.png)

## React (ts)
Вызвать ErrorBoundary
```js
const handleError = (): string => {
    throw Object.assign(
        new Error('Cannot read properties'),
        { message: 'Cannot read properties' }
    );
};

handleError();
```
