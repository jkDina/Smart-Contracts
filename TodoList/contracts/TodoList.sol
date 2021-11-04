pragma solidity >=0.4.21 <0.7.0;
contract TodoList {
  uint public taskCount = 0;
  struct Task {
    uint id;
    string content;
  }
  mapping(uint => Task) public tasks;
  event TaskCreated(
    uint id,
    string content
  );
  constructor() public {
    createTask("Сходить в магазин");
  }
  function createTask(string memory _content) public {
    taskCount ++;
    tasks[taskCount] = Task(taskCount, _content);
    emit TaskCreated(taskCount, _content);
  }
}