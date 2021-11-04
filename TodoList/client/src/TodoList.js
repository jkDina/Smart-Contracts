import React, { Component } from 'react';
class TodoList extends Component{
    render() {
        return (
          <div>
            <form onSubmit={(event) => {
                event.preventDefault()
                this.props.createTask(this.task.value)}}>
                <input type="text" 
                  ref={(input) => {
                  this.task = input}}/>
            </form>              
            {this.props.tasks.map((task, key) => {
             return(
             <div  key={key}>{task.content}</div>)})}
          </div>
        );
      }
}
export default TodoList;