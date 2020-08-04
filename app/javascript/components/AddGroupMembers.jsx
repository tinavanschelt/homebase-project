import React, { Fragment } from 'react'
import axios from 'axios'
import PropTypes from 'prop-types'
import { iconX } from '../helpers/icons'

class AddGroupMembers extends React.Component {
    constructor(props) {
        super(props)
        this.state = {
            fieldsVisible: false,
            members: props.members,
            invitations: props.invitations,
        }

        const csrfToken = document.getElementsByName('csrf-token')[0]
        this.csrfToken = csrfToken ? csrfToken.content : ''

        this.toggleFields = this.toggleFields.bind(this)
        this.handleFieldChange = this.handleFieldChange.bind(this)
        this.addNewMember = this.addNewMember.bind(this)
        this.toggleMemberStatus = this.toggleMemberStatus.bind(this)
        this.deleteInvite = this.deleteInvite.bind(this)
    }

    toggleFields() {
        this.setState({ fieldsVisible: !this.state.fieldsVisible })
    }

    handleFieldChange(e) {
        const { target } = e
        this.setState({ [target.id]: target.value })
    }

    toggleMemberStatus(id, active) {
        const { groupId } = this.props

        axios
            .put(`/toggle_member_status`, {
                authenticity_token: this.csrfToken,
                active: active,
                user_id: id,
                group_id: groupId,
            })
            .then(({ data }) => {
                const { members } = this.state
                const memberIndex = members.findIndex(m => m.id == id)
                const updatedMembers = members
                updatedMembers[memberIndex].active = active

                this.setState({
                    members: updatedMembers,
                })
            })
            .catch(res => {
                console.log(res)
            })
    }

    deactivateMember() {
        axios
            .post(`/group_members/`, {
                authenticity_token: this.csrfToken,
                email: this.state.email,
                user_id: userId,
                group_id: groupId,
            })
            .then(({ data }) => {
                const { invitations } = this.state
                this.setState({
                    invitations: [
                        ...invitations,
                        ...[{ email: data.email, id: data.id }],
                    ],
                    email: '',
                })
            })
            .catch(res => {
                console.log(res)
            })
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
                    invitations: [
                        ...invitations,
                        ...[{ email: data.email, id: data.id }],
                    ],
                    email: '',
                })
            })
            .catch(res => {
                console.log(res)
            })
    }

    deleteInvite(id) {
        axios
            .delete(`/invitations/${id}`, {
                authenticity_token: this.csrfToken,
            })
            .then(({ data }) => {
                const { invitations } = this.state
                const updatedInvitations = invitations.filter(
                    invite => invite.id != id
                )
                this.setState({
                    invitations: updatedInvitations,
                    email: '',
                })
            })
            .catch(res => {
                console.log(res)
            })
    }

    render() {
        const { fieldsVisible, email, invitations, members } = this.state
        const { groupCode } = this.props
        const inviteUrl = `${window.location.origin}/invitations/${groupCode}`

        return (
            <div className="group-members-form">
                <h3>Members</h3>
                <div className="box-with-border">
                    {members && members.length == 0 ? (
                        <Fragment>
                            This group does not have any members yet.
                        </Fragment>
                    ) : (
                        <Fragment>
                            {members.map(member => (
                                <div className="list-item">
                                    <span>{member.email}</span>
                                    {member.active ? (
                                        <a
                                            onClick={() =>
                                                this.toggleMemberStatus(
                                                    member.id,
                                                    false
                                                )
                                            }
                                        >
                                            Deactivate
                                        </a>
                                    ) : (
                                        <a
                                            onClick={() =>
                                                this.toggleMemberStatus(
                                                    member.id,
                                                    true
                                                )
                                            }
                                        >
                                            Activate
                                        </a>
                                    )}
                                </div>
                            ))}
                        </Fragment>
                    )}
                </div>
                <h3>Invites</h3>
                <div className="box-with-border">
                    {invitations && invitations.length == 0 ? (
                        <Fragment>
                            This group does not have any invitees yet. <br />
                            Click on "Add Group Members" <i>or</i> share the
                            sign-up link,{' '}
                            <a href={inviteUrl} target="_blank">
                                {inviteUrl}
                            </a>
                            , with the people you would like to add to the
                            group.
                        </Fragment>
                    ) : (
                        <Fragment>
                            {invitations.map(invite => (
                                <div className="list-item">
                                    <span>{invite.email}</span>
                                    <div
                                        onClick={() =>
                                            this.deleteInvite(invite.id)
                                        }
                                    >
                                        <img
                                            src={iconX}
                                            alt="delete"
                                            className="list-item__delete"
                                        />
                                    </div>
                                </div>
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
    groupCode: PropTypes.string.isRequired,
}

export default AddGroupMembers
