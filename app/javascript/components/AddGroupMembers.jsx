import React, { Fragment } from 'react'
import axios from 'axios'
import PropTypes from 'prop-types'
import { logo, iconUser, iconMenu } from '../helpers/icons'

class AddGroupMembers extends React.Component {
    constructor(props) {
        super(props)
        this.state = { fieldsVisible: false, invitations: props.invitations }

        const csrfToken = document.getElementsByName('csrf-token')[0]
        this.csrfToken = csrfToken ? csrfToken.content : ''

        this.toggleFields = this.toggleFields.bind(this)
        this.handleFieldChange = this.handleFieldChange.bind(this)
        this.addNewMember = this.addNewMember.bind(this)
    }

    toggleFields() {
        this.setState({ fieldsVisible: !this.state.fieldsVisible })
    }

    handleFieldChange(e) {
        const { target } = e
        this.setState({ [target.id]: target.value })
    }

    addNewMember() {
        const { userId, groupId } = this.props

        axios
            .post(`/invitations`, {
                authenticity_token: this.csrfToken,
                email: this.state.email,
                user_id: userId,
                group_id: groupId,
            })
            .then(({ data }) => {
                const { invitations } = this.state
                this.setState({
                    invitations: [...invitations, ...[data.email]],
                    email: '',
                })
            })
            .catch(res => {
                console.log(res)
            })
    }

    render() {
        const { fieldsVisible, email, invitations } = this.state
        const { members } = this.props

        console.log(invitations)

        return (
            <div className="group-members-form">
                <h3>Members</h3>
                <div className="box-with-border">
                    {members && members.length == 0 ? (
                        <Fragment>
                            This groups does not have any members yet.
                        </Fragment>
                    ) : (
                        <Fragment>
                            {members.map(email => (
                                <div>{email}</div>
                            ))}
                        </Fragment>
                    )}
                </div>
                <h3>Invites</h3>
                <div className="box-with-border">
                    {invitations && invitations.length == 0 ? (
                        <Fragment>
                            This groups does not have any invites yet.
                        </Fragment>
                    ) : (
                        <Fragment>
                            {invitations.map(email => (
                                <div>{email}</div>
                            ))}
                        </Fragment>
                    )}
                </div>
                {!fieldsVisible && (
                    <div
                        className="btn btn--primary"
                        onClick={() => this.toggleFields()}
                    >
                        Add Group Members
                    </div>
                )}
                {fieldsVisible && (
                    <div className="grid grid--four-up">
                        <div className="field">
                            <label htmlFor="">Send email invitation</label>
                            <input
                                autoFocus="autoFocus"
                                type="email"
                                onChange={e => this.handleFieldChange(e)}
                                placeholder="newmember@family.com"
                                value={email}
                                name="email"
                                id="email"
                                required
                            />
                        </div>
                        <div>
                            <div
                                className="btn btn--primary"
                                onClick={() => this.addNewMember()}
                            >
                                Send Invite
                            </div>
                        </div>
                    </div>
                )}
            </div>
        )
    }
}

AddGroupMembers.propTypes = {
    groupId: PropTypes.number.isRequired,
    members: PropTypes.array.isRequired,
    invitations: PropTypes.array.isRequired,
    userId: PropTypes.number.isRequired,
}

export default AddGroupMembers
