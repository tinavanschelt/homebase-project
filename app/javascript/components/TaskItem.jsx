import React from 'react'
import axios from 'axios'
import PropTypes from 'prop-types'

class TaskItem extends React.Component {
    constructor(props) {
        super(props)

        const csrfToken = document.getElementsByName('csrf-token')[0]
        this.csrfToken = csrfToken ? csrfToken.content : ''

        this.state = { checked: props.completed }
        this.toggleTaskComplete = this.toggleTaskComplete.bind(this)
    }

    toggleTaskComplete() {
        const { id } = this.props

        axios
            .put(`/toggle_task_complete`, {
                authenticity_token: this.csrfToken,
                completed: !this.state.checked,
                id: id,
            })
            .then(({ data }) => {
                console.log(data, !this.state.checked)
                this.setState({ checked: !this.state.checked })
            })
            .catch(res => {
                console.log(res)
            })
    }

    render() {
        const { checked } = this.state
        const { id, title, due } = this.props

        return (
            <label
                className="field field--checkbox"
                style={{ margin: 0 }}
                htmlFor={`task_${id}`}
            >
                <input
                    type="checkbox"
                    name={`task[${id}]`}
                    id={`task_${id}`}
                    onChange={() => this.toggleTaskComplete()}
                    checked={checked}
                />
                <a href={`/tasks/${id}`} className="list-item">
                    {title} ({due})
                </a>
            </label>
        )
    }
}

TaskItem.propTypes = {
    completed: PropTypes.boolean,
    due: PropTypes.string.isRequired,
    id: PropTypes.number.isRequired,
    title: PropTypes.string.isRequired,
}

export default TaskItem
