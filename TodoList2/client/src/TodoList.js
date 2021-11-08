import React, { Component } from 'react';
class TodoList extends Component{
    render() {
        return (
          <div>
            <ul id="taskList" className="list-unstyled"></ul>
            <form onSubmit={(event) => {
                event.preventDefault()
                this.props.createTask(this.task.value)}}>
                <div className="ui icon input">
                <input type="text" name="task" 
                  ref={(input) => {
                  this.task = input}}/>
            </div>
            </form>
            {this.props.tasks.map((task, key) => {
             return(
            <div class="ui middle aligned divided list">  
             <div class="item">
                            <div class="right floated content">
                            <button 
                            id={task.id}
                            onClick={(event)=>{
                                console.log(event.target.id)
                                this.props.toggleCompleted(event.target.id)
                            }}
                            class={task.completed ?"ui red button":"ui acrive button"}>
                            Выполнено
                            </button>
                            </div>
                            <div class="content">{task.content}</div>
                        </div>
              </div>
             )
             })}
          </div>
        );
      }
}
export default TodoList;