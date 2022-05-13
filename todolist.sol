// SPDX-License-Identifier:MIT
pragma solidity ^0.8.4;

contract Todo {
    address private owner;

    /*
    Create struct called task 
    The struct has 3 fields : id,title,Completed
    Choose the appropriate variable type for each field.
    */
    struct Task {
        uint256 id;
        string title;
        bool completed;
    }

    /// Create a counter to keep track of added tasks
    uint256 private taskCount;

    /*
    create a mapping that maps the counter created above with the struct taskcount
    key should of type integer
    */
    mapping(uint256 => Task) private tasks;

    /*
    Define a constructor
    the constructor takes no arguments
    Set the owner to the creator of the contract
    Set the counter to  zero
    */
    constructor() {
        owner = msg.sender;
        taskCount = 0;
    }

    /*
    Define 2 events
    taskadded should provide information about the title of the task and the id of the task
    taskcompleted should provide information about task status and the id of the task
    */
    event TaskAdded(string title, uint256 id);
    event TaskCompleted(bool status, uint256 id);

    /*
    Create a modifier that throws an error if the msg.sender is not the owner.
    */
    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can call this");
        _;
    }

    /*
    Define a function called addTask()
    This function allows anyone to add task
    This function takes one argument , title of the task
    Be sure to check :
    taskadded event is emitted
    */
    function addTask(string memory taskTitle) public {
        tasks[taskCount] = Task({
            id: taskCount,
            title: taskTitle,
            completed: false
        });
        emit TaskAdded(taskTitle, taskCount);
        taskCount++;
    }

    /*
    Define a function to get total number of task added in this contract
    */
    function getTotalTasks() public view returns (uint256) {
        return taskCount;
    }

    /*
    Define a function gettask()
    This function takes 1 argument ,task id and 
    returns the task name ,task id and status of the task
    */
    function getTask(uint256 taskId)
        public
        view
        returns (
            string memory,
            uint256,
            bool
        )
    {
        Task memory desiredTask = tasks[taskId];
        return (desiredTask.title, desiredTask.id, desiredTask.completed);
    }

    /*
    Define a function marktaskcompleted()
    This function takes 1 argument , task id and 
    set the status of the task to completed 
    Be sure to check:
    taskcompleted event is emitted
    */
    function markTaskCompleted(uint256 taskId) public onlyOwner {
        Task storage desiredTask = tasks[taskId];
        desiredTask.completed = true;
        emit TaskCompleted(desiredTask.completed, desiredTask.id);
    }
}
