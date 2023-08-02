Feature: Part1 - Verify Endpoints and Status Codes
	
	Background:
		* set base url | "http://localhost:6250"
	
	Scenario: Make sure GET template endpoint works
		Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Birthday Card",
			  "description": "A card that says happy birthday.",
			  "template": "<b>Hello {{name}}!</b><br/> Happy {{age}}th birthday!<br/> {{turning}} is coming up soon!",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "name": {
			        "type": "string"
			      },
			      "age": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "name",
			      "age"
			    ]
			  },
			  "logic": {
			    "turning": {
			      "+": [
			        {
			          "var": "age"
			        },
			        1
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		
		Given set endpoint | "/templates/:id"
		When  send request | "get"
		Then verify status | 200
		
		

	Scenario: Make sure POST template endpoint works
		Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Birthday Card",
			  "description": "A card that says happy birthday.",
			  "template": "<b>Hello {{name}}!</b><br/> Happy {{age}}th birthday!<br/> {{turning}} is coming up soon!",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "name": {
			        "type": "string"
			      },
			      "age": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "name",
			      "age"
			    ]
			  },
			  "logic": {
			    "turning": {
			      "+": [
			        {
			          "var": "age"
			        },
			        1
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		
		
	Scenario: Make sure delete endpoint works
		Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Birthday Card",
			  "description": "A card that says happy birthday.",
			  "template": "<b>Hello {{name}}!</b><br/> Happy {{age}}th birthday!<br/> {{turning}} is coming up soon!",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "name": {
			        "type": "string"
			      },
			      "age": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "name",
			      "age"
			    ]
			  },
			  "logic": {
			    "turning": {
			      "+": [
			        {
			          "var": "age"
			        },
			        1
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		Given set endpoint | "/templates/:id"
		When send request | "delete"
		Then verify status | 200
		
	Scenario: Make sure PUT template endpoint works
		Given set endpoint | "/templates"
		And set request body 
		"""
			{
			  "name": "Birthday Card",
			  "description": "A card that says happy birthday.",
			  "template": "<b>Hello {{name}}!</b><br/> Happy {{age}}th birthday!<br/> {{turning}} is coming up soon!",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "name": {
			        "type": "string"
			      },
			      "age": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "name",
			      "age"
			    ]
			  },
			  "logic": {
			    "turning": {
			      "+": [
			        {
			          "var": "age"
			        },
			        1
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "post"
		Then verify status | 200
		
		Given set endpoint | "/templates/:id"
		And set request body 
		"""
			{
			  "name": "New Name",
			  "description": "A card that says happy birthday.",
			  "template": "<b>Hello {{name}}!</b><br/> Happy {{age}}th birthday!<br/> {{turning}} is coming up soon!",
			  "headers": [
			    {
			      "name": "Content-Type",
			      "value": "text/html"
			    }
			  ],
			  "dataSchema": {
			    "type": "object",
			    "properties": {
			      "name": {
			        "type": "string"
			      },
			      "age": {
			        "type": "number"
			      }
			    },
			    "required": [
			      "name",
			      "age"
			    ]
			  },
			  "logic": {
			    "turning": {
			      "+": [
			        {
			          "var": "age"
			        },
			        1
			      ]
			    }
			  }
			}
		"""
		And set header | "Content-Type" "application/json"
		When send request | "put"
		Then verify status | 200
		
		