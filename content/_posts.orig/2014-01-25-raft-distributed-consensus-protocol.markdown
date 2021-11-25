---
layout: post
title: "Raft - Distributed Consensus Protocol"
date: 2014-01-25 11:52:13 -0800
comments: true
categories: 
---
Rafe is a distributed consensus protocol, which allows a collection of processes to maintain consistency even in the face of multiple node failure. The two main tenants of the protocol are leader election and log replication.
<!-- more -->
### Learn Notes

#### Raft - Distributed Consensus

  * State
    * Follower
      * up to Candidate, if it can't hear from leader (i.e. stop receiving heartbeats)
      * all nodes initial state
    * Condidate
      * up to Leader, if it gets votes from a majority of nodes
      * down to Follower, if it gets "Request Vote"
    * Leader
      * down to follower, when it sees the higher election term
      * all changes to the system go through the leader
      * only one in a system
  * Activity
    * Leader Election
      * 1\. send 'Request Vote' by Candidate
      * 2\. if the receiving node hasn't voted yet in this term then it votes for the candidate
      * 3\. then the node resets its election timeout
      * 4\. once a candidate has a majority of votes
      * 5\. it becomes leader
    * Log Replication
      * 1\. a client send a change to the leader
      * 2\. the change is appended to the leader's log, uncommited
      * 3\. the change is sent/replicate to the followers on the next heartbeat
      * 4\. an entry is committed on leader once a majority of followers acknowledge it
      * 5\. the leader notifies the followers than the entry is committed
      * 6\. a response is sent to the client
  * Message
    * Append Entries
        * Original from Leader
        * Respond by Followers
        * In a intervals specified by the heartbeat timeout
    * Request Vote
        * Original from Candidate
        * Votes by the receiving nodes (one for each node, at same term)
        * Immediately
  * Timeout
    * Election Timeout
        * the amount of time a follower waits until becoming a candidate
        * randomized to be between 150ms and 300ms
        * doesn't occur on Leader
    * Heatbeat Timeout
        * should be shorter than Election Timeout
        * occurs on all nodes
  * Guarantee
    * because: requiring a majority of votes
    * only one leader can be elected per term

### JSON expression
Here is a json, try to express the node to communicate with Raft protocol:
```json
{
  "message_type": [
    "REQUEST_VOTE",
    "VOTE",
    "APPEND_ENTRIES",
    "RESPOND_to_append_entries"
  ],
  "heartbeat": 100,
  "election": "random_time(150-300ms)",
  "name": "random_string",
  "state": "follower",
  "send_message": {
    "to": "who",
    "type": "message_type"
  },
  "reset_timeout": "timeout_type: heartbeat|election",
  "stop_election": "",
  "leader": "who",
  "term": {
    "no": 0,
    "vote_count": 1
  }
}
```

### Reference:
1. https://ramcloud.stanford.edu/wiki/download/attachments/11370504/raft.pdf
2. http://thesecretlivesofdata.com/raft/

> Supported by [FreePlane][1], a great mind map editor.
> Supported by [JSON Editor Online](http://jsoneditoronline.org/).
> Supported by [HTML to MD](https://github.com/neocotic/html.md).
> Written with [StackEdit](https://stackedit.io/).

  [1]: http://sourceforge.net/projects/freeplane/
