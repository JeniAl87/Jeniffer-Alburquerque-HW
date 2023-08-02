Feature: Part3 - Schema Validation

	Background:
		* set base url | "http://localhost:6250"
	

  Scenario: Verify that variables that are not required wont cause api call to fail
    Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Birthday Card",
			  "description": "A card that says happy birthday.",
			  "template": "{{num}} + 10 = {{result}}. Optional name is {{name}}",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "num": {
			        "type": "number"
			      },
			      "name": {
			          "type": "string"
			      }
			    },
			    "required": [
			      "num"
			    ]
			  },
			  "logic": {
			    "result": {
			      "+": [
			        {
			          "var": "num"
			        },
			        10
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		Given set endpoint | "/templates/:id/process"
		And set header | "Content-Type" "application/json"
		And set request body
		"""
			{
				"num": 10
			}
		"""
		When send request | "post"
		Then verify status | 200


  Scenario Outline: Verify that skipping required variables will cause api call to fail
  	Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Birthday Card",
			  "description": "A card that says happy birthday.",
			  "template": "{{num}} + 10 = {{result}}. Required name is {{name}}",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "num": {
			        "type": "number"
			      },
			      "name": {
			          "type": "string"
			      }
			    },
			    "required": [
			      "num",
			      "name"
			    ]
			  },
			  "logic": {
			    "result": {
			      "+": [
			        {
			          "var": "num"
			        },
			        10
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		Given set endpoint | "/templates/:id/process"
		And set header | "Content-Type" "application/json"
		And set request body
		"""
			{
				"num": 10
			}
		"""
		When send request | "post"
		Then verify status | 400
		
		
		
    