sinon = require 'sinon'
sinon_chai = require 'sinon-chai'
chai = require 'chai'

should = do chai.should
chai.use sinon_chai

BaseCRUD = require '../../app/lib/crud.coffee'
Talk = require '../../app/models/talk.coffee'

CRUDCtrl = new BaseCRUD Talk

mock = require '../mock.coffee'

do require '../db.coffee'

describe 'CRUD', ->
	describe '#create', ->

		it 'returns promise and resolve it with created document', (done) ->

			talk = mock.talk

			success = (content) ->
				content.should.exist
				do done

			failure = ->

			CRUDCtrl.create talk
				.then success, failure

		it '''returns promise and reject \
					it with err if document to create is invalid''', (done) ->

			talk = mock.invalid_talk

			success = ->

			failure = (err) ->
				err.should.exist
				do done

			CRUDCtrl.create talk
				.then success, failure

	describe '#read', ->

		it 'returns promise and resolve it with whole collection', (done) ->

			mock.talks 10, (mocked) ->

				success = (content) ->
					content.length.should.equal mocked.length
					do done

				failure = ->

				CRUDCtrl.read()
					.then success, failure

	describe '#get_by_id', ->

		it 'returns promise and resolve it with found document', (done) ->

			mock.talks 10, (mocked) ->

				success = (found) ->
					found.should.exist
					do done

				failure = ->

				id = mocked[2]._id

				CRUDCtrl.get_by_id id
					.then success, failure
